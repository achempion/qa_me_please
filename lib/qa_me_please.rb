require "qa_me_please/version"
require "qa_me_please/configuration"
require "qa_me_please/github_wizard"

module QaMePlease
  extend Configuration

  def self.publish!
    github_wizard =
      GithubWizard.new \
        repo: configuration.repo,
        repo_access_key: configuration.repo_access_key,
        qa_branch: configuration.qa_branch,
        qa_label: configuration.qa_label

    github_wizard.publish!
  end
end
