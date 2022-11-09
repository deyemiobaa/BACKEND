class Api::V1::MemorySerializer
  include JSONAPI::Serializer
  attributes :id, :prompt, :title, :story, :image_url, :public, :favorite, :created_at
end
