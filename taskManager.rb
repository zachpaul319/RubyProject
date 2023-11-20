############################################# TASK #############################################
class Task
  # object attributes. "attr_accessor" creates an instance variable AND corresponding access method to read it
  attr_accessor :title, :description, :completed

  # Constructor
  def initialize(title, description)
    @title = title
    @description = description
    @completed = false
  end # "end" keyword used to determine end of block. No colons or curly braces, just "end"

  # demonstrates switch-case (case-when)
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

  def mark_complete # methods with zero parameters do not need parentheses
    @completed = true
  end

  def to_string
    "#{@title}\n\t#{@description}" # no return keyword needed. Also encapsulates string interpolation via #{}
  end
end

############################################# TASK LIST #############################################
class TaskList
  # List of Task objects
  attr_accessor :task_list

  # constructor initializes empty list
  def initialize
    @task_list = []
  end

  def print_all_tasks
    @task_list.each_with_index do |task, idx| # "each_with_index" allows us to iterate over an enumerable (e.g. array). We can access both index and element
      puts "#{idx+1}. #{task.to_string}" # when calling methods with zero parameters (e.g. to_string), parentheses are not needed
    end
  end

  def print_incomplete_tasks
    @task_list.each do |task| # Like a forEach
      unless task.completed # "unless" similar to a guard in Swift. Like an "if not ..."
        puts "#{task.to_string}"
      end
    end
  end

  # rather than having user type in a task, they will choose the task from their task list, hence this method
  def ask_for_task
    print_all_tasks

    print "Task Number [Between 1 and #{@task_list.length}]: "
    gets.chomp.to_i - 1 # read input (gets), remove newline char (chomp), convert to integer (to_i), subtract 1 for correct index. Again, no return keyword
  end

  def get_task(idx)
    @task_list[idx]
  end

  def add_task(task)
    @task_list << task # << is the append operator. Can be used for arrays or strings
  end

  # static method that resembles functional programming style. Yes, there is a better way to do this, but this is for demonstration purposes
  def self.search_task(task_list, title, idx)
    current = task_list[idx]

    if idx >= task_list.length
      puts "Could not find task: '#{title}'"
    elsif current.title.eql? title # compares strings. "==" also works, but it doesn't compare types
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

############################################# TASK MANAGER EXECUTION #############################################
task_list = TaskList.new # instantiate object. If constructor has no parameters, then can call "new" without parentheses
puts "Welcome to the Ruby Task Manager!" # "puts" automatically creates newline

while true
  print "\nPlease enter a desired action:\n\tprint\n\tadd\n\tsearch\n\tupdate\n\tcomplete\n\tshow_incomplete\n\tremove\nDesired action: " # "print" doesn't create newline
  choice = gets.chomp

  case choice
  when "print"
    task_list.print_all_tasks

  when "add"
    puts "Please answer the following prompts:"
    print "\tTask title: "
    title = gets.chomp

    print "\tTask description: "
    description = gets.chomp

    task = Task.new(title, description)
    task_list.add_task(task)

    puts "\nSuccessfully added task"

  when "search"
    print "Task to search: "
    title = gets.chomp

    TaskList.search_task(task_list.task_list, title, 0) # static method call

  when "update"
    idx = task_list.ask_for_task

    puts "Please select a field to update:\n\ttitle\n\tdescription"
    print "Field: "
    field = gets.chomp

    print "New #{field}: "
    updated_content = gets.chomp

    task_list.update_task(idx, field, updated_content)

    puts "\nSuccessfully updated task"

  when "complete"
    idx = task_list.ask_for_task
    task = task_list.get_task(idx)

    task.mark_complete
    puts "\n#{task.title} has been marked complete"

  when "show_incomplete"
    task_list.print_incomplete_tasks

  when "remove"
    idx = task_list.ask_for_task
    task_list.remove_task(idx)

    puts "\n#{task_list.get_task(idx).title} has been removed"
  else
    puts "Invalid action"
  end
end
