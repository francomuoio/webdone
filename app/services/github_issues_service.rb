class GithubIssuesService
  def initialize(github_token)
    @github = Github.new(oauth_token: github_token)
  end

  def get_issues(projet)
    user, repo = projet.repository_url.split('/').last(2)
    response = @github.issues.list(
      user: user,
      repo: repo,
      auto_pagination: true
    )
    response.to_ary
  end

  def get_comments(projet)
    user, repo = projet.repository_url.split('/').last(2)
    response = @github.issues.comments.list(
      user: user,
      repo: repo,
      auto_pagination: true
    )
    response.to_ary
  end

  # def get_description
  #   user, repo = projet.repository_url.split('/').last(2)
  #   response = @github.issues.description.list(
  #     user: user,
  #     repo: repo,
  #     auto_pagination: true
  #   )
  #   response.to_ary
  # end

  def create_comment(projet, issue_number, body)
    user, repo = projet.repository_url.split('/').last(2)
    @github.issues.comments.create(
      user: user,
      repo: repo,
      number: issue_number,
      body: body
    )
  end
end
