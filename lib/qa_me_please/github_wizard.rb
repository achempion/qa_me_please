require 'json'

module QaMePlease
  class GithubWizard

    def initialize(repo:, repo_access_key:, qa_branch:, qa_label:)
      @repo = repo
      @repo_access_key = repo_access_key
      @qa_branch = qa_branch
      @qa_label = qa_label
    end

    def publish!
      check_origin!

      fork!
      merge!
      force_push!
    end

    private

    def check_origin!
      origin = `git config --get remote.origin.url`

      raise 'origin repo and repo from config are not equal' if (origin =~ /#{@repo}/).nil?
    end

    def fork!
      `git branch -D #{@qa_branch}`
      `git checkout -b #{@qa_branch}`
    end

    def merge!
      search_url = "https://api.github.com/search/issues?q=label:#{@qa_label}+state:open+repo:#{@repo}+type:pr"

      #
      # get all pull requests
      #

      pull_requests = JSON.parse curl(search_url)

      mergeable_branches = []
      not_mergeable_branches = []


      #
      # determine branches we can merge without conflicts
      #

      pull_requests['items'].each do |issue|
        pr_info = JSON.parse curl(issue['pull_request']['url'])

        if pr_info['mergeable']
          # can merge
          mergeable_branches << pr_info['head']['ref']
        else
          # can't merge
          not_mergeable_branches << pr_info['head']['ref']
        end
      end

      #
      # merge mergeable branches
      #

      mergeable_branches.each {|branch| `git merge origin/#{branch}` }

      puts "\e[32mMerged branches: #{mergeable_branches.join(', ')}\e[0m" if mergeable_branches.any?

      #
      # notify about branches that need to be rebased (can't be merged now)
      #

      puts "\e[31mCan't be merged: #{not_mergeable_branches.join(', ')}\e[0m" if not_mergeable_branches.any?

    end

    def force_push!
      `git push --set-upstream origin #{@qa_branch} --force`
    end

    def curl(url)
      `curl -u #{@repo_access_key} #{url}`
    end

  end
end
