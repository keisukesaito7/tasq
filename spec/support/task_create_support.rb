module TaskCreateSupport
  def task_create(user, task)
    find_link("新規作成", href: new_task_path).click
    fill_in 'task_title', with: task.title
    fill_in 'task_purpose', with: task.purpose
    fill_in 'task_goal', with: task.goal
    find("input[name='commit']").click
    @var_for_id = user.tasks.find_by(title: task.title)
    expect(current_path).to eq task_path(@var_for_id)
  end
end