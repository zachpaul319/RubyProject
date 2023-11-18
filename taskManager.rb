class Task
  attr_accessor :title, :description, :completed

  def initialize(title, description)
    @title = title
    @description = description
    @completed = false
  end

  def update(field_to_update, updated_content)
    case field_to_update
    when "title"
      @title = updated_content
    when "description"
      @description = updated_content
    else
      puts "No such field exists"
    end
  end

  def mark_complete
    @completed = true
  end

  def to_string
    "#{@title}\n\tDescription: #{@description}"
  end
end


class TaskList
  attr_accessor :task_list

  def initialize
    @task_list = []
  end

  def print_tasks
    @task_list.each_with_index do |task, idx|
      puts "#{idx+1}. #{task.to_string}"
    end
  end

  def ask_for_task
    print_tasks

    print "Task Number [Between 1 and #{@task_list.length}]: "
    gets.chomp.to_i - 1
  end

  def add_task(task)
    @task_list << task
  end

  # static method that resembles functional programming style
  def self.search_task(task_list, title, idx)
    current = task_list[idx]

    if idx >= task_list.length
      puts "Could not find task: '#{title}'"
    elsif current.title.eql? title
      puts "Found task: '#{title}'"
    else
      search_task(task_list, title, idx+1)
    end
  end

  def update_task(idx, field, updated_content)
    @task_list[idx].update(field, updated_content)
  end

  def remove_task(idx)
    @task_list.delete_at(idx)
  end
end


task_list = TaskList.new
puts "Welcome to the Ruby Task Manager!"

while true
  print "Please select a desired action:\n\tprint\n\tadd\n\tsearch\n\tupdate\n\tremove\nDesired action: "
  choice = gets.chomp

  case choice
  when "print"
    task_list.print_tasks
  when "add"
    puts "Please answer the following prompts"
    print "\tTask title: "
    title = gets.chomp

    print "\tTask description: "
    description = gets.chomp

    task = Task.new(title, description)
    task_list.add_task(task)

  when "search"
    print "Task to search: "
    title = gets.chomp

    TaskList.search_task(task_list.task_list, title, 0)

  when "update"
    idx = task_list.ask_for_task

    puts "Please select a field to update:\n\ttitle\n\tdescription"
    field = gets.chomp

    print "New Content: "
    updated_content = gets.chomp

    task_list.update_task(idx, field, updated_content)

  when "remove"
    idx = task_list.ask_for_task
    task_list.remove_task(idx)
  else
    puts "Invalid action"
  end
end
