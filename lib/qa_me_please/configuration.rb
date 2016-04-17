module QaMePlease
  module Configuration
    class Config
      attr_accessor :repo, :repo_access_key, :qa_branch, :qa_label
      attr_reader :repo_provider

      def initialize(opts = {})
        @repo_provider = 'github'
        @repo_access_key = opts[:repo_access_key] || 'username:token'

        @repo = opts[:repo] || 'achempion/qa_me_please'

        @qa_branch = opts[:qa_branch] || 'testing'
        @qa_label = opts[:qa_label] || 'testing'
      end
    end

    # configure config
    def configure(&block)
      yield(configuration)
    end

    # access to config
    def configuration
      @configuration ||= Config.new
    end
  end
end
