class Api::V1::MemoriesController < ApplicationController
  before_action :set_api_v1_memory, only: %i[show update destroy]
  before_action :authenticate_user!

  # GET /api/v1/memories
  def index
    user = current_user
    @api_v1_memories = Api::V1::Memory.includes(image_attachment: :blob).where(user: user).order(created_at: :desc)
    memories_data = {}
    @api_v1_memories.each do |memory|
      date = memory.created_at.strftime('%Y %B')
      memories_data[date] = [] unless memories_data[date]
      memories_data[date] << Api::V1::MemorySerializer.new(memory).serializable_hash[:data][:attributes]
    end

    data = []
    memories_data.each do |key, value|
      data << { month: key, memories: value }
    end
    render json: data
  end

  # GET /api/v1/memories/public
  def public_memories
    @api_v1_memories = Api::V1::Memory.includes(:user).where(public: true).order(created_at: :desc).with_attached_image
    public_memories_data = []
    @api_v1_memories.each do |memory|
      data = {
        name: memory.user.name,
        memory: Api::V1::MemorySerializer.new(memory).serializable_hash[:data][:attributes]
      }
      public_memories_data << data
    end
    render json: public_memories_data
  end

  # GET /api/v1/memories/1
  def show
    render json: Api::V1::MemorySerializer.new(@api_v1_memory).serializable_hash[:data][:attributes]
  end

  # POST /api/v1/memories
  def create
    @api_v1_memory = Api::V1::Memory.new(api_v1_memory_params)
    @api_v1_memory.user = current_user

    if @api_v1_memory.save
      render json: { message: 'Memory created successfully' }, status: :created
    else
      render json: { error: @api_v1_memory.errors }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/memories/1
  def update
    if @api_v1_memory.update(api_v1_memory_params)
      render json: @api_v1_memory
    else
      render json: @api_v1_memory.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/memories/1
  def destroy
    if @api_v1_memory.destroy
      render json: { message: 'Memory deleted successfully' }, status: :ok
    else
      render json: { error: @api_v1_memory.errors }, status: :unprocessable_entity
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_api_v1_memory
    @api_v1_memory = Api::V1::Memory.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def api_v1_memory_params
    params.require(:api_v1_memory).permit(:prompt, :story, :title, :public, :favorite, :image)
  end
end
