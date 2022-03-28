module Resolvers
  class PostsResolver < Resolvers::BaseResolver
    type [Types::PostType], null: false
    argument :id, ID, required: true

    def resolve()
      Post.all
    end
  end
end