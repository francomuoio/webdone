module IssuesHelper
  def comments_for_issue(issue, comments)
    comments.select do |comment|
      comment["issue_url"] == issue["url"]
    end
  end

  def issues_done(issues)
    issues_done = []
    issues.each do |issue|
      issue['labels'].each do |label|
        if label['name'] == 'done'
          issues_done << issue
        end
      end
    end
    issues_done
  end
end
