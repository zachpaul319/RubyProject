############################################# TASK #############################################
class Task
  # object attributes. "attr_accessor" creates an instance variable AND corresponding access method to read it
  attr_accessor :title, :description, :completed

  # Constructor. Overrides BasicObject method
  def initialize(title, description)
    @title = title
    @description = description
    @completed = false
  end # "end" keyword used to determine end of block. No colons or curly braces needed, just "end"

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
    @task_list.each_with_index do |task, idx|
      unless task.completed # "unless" similar to a guard in Swift. Like an "if not ..."
        puts "#{idx+1}. #{task.to_string}"
      end
    end
  end

  # rather than having user type in a task, they will choose the task from their task list, hence this method
  def ask_for_task(action)
    puts "\nSelect task to #{action}:"
    print_all_tasks

    print "Task Number [Between 1 and #{@task_list.length}]: " # arrays have built in length property, like in most languages
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

############################################# RANDOM FUNCTIONS #############################################
# Count to 10
def thread_func
  (1..10).each { |i| # same as for (i = 0; i < 10 ; i++)
    puts "#{i}"
    sleep(1)
  }
end

def kick_off_threads
  puts "Starting Thread"
  thread = Thread.new{thread_func} # executes the code provided in the block {}. Here, we are just calling thread_func
  # thread.join #TODO: uncomment. "join" waits for thread to finish
end

def factorial(num)
  if num == 0 || num == 1
    1
  else
    num * factorial(num - 1)
  end
end

############################################# TASK MANAGER EXECUTION #############################################
task_list = TaskList.new # instantiate object. If constructor has no parameters, then can call "new" without parentheses
puts "Welcome to the Ruby Task Manager!" # "puts" automatically creates newline

while true
  print "\nPlease enter a desired action:\n\tprint\n\tadd\n\tsearch\n\tupdate\n\tcomplete_task\n\tshow_incomplete\n\tremove\n\tthread\n\tfactorial\nDesired action: " # "print" doesn't create newline
  choice = gets.chomp

  case choice
  when "print"
    puts "\nTask List:"
    task_list.print_all_tasks

  when "add"
    puts "\nPlease answer the following prompts:"
    print "\tTask title: "
    title = gets.chomp

    print "\tTask description: "
    description = gets.chomp

    task = Task.new(title, description)
    task_list.add_task(task)

    puts "\nSuccessfully added task '#{task.title}'"

  when "search"
    print "\nTask to search: "
    title = gets.chomp

    TaskList.search_task(task_list.task_list, title, 0) # static method call

  when "update"
    idx = task_list.ask_for_task("update")

    puts "\nPlease select a field to update:\n\ttitle\n\tdescription"
    print "Field to update: "
    field = gets.chomp

    print "\nNew #{field}: "
    updated_content = gets.chomp

    task_list.update_task(idx, field, updated_content)

    puts "\nSuccessfully updated task"

  when "complete_task"
    idx = task_list.ask_for_task("complete")
    task = task_list.get_task(idx)

    task.mark_complete
    puts "\n'#{task.title}' has been marked complete"

  when "show_incomplete"
    puts "\nIncomplete tasks:"
    task_list.print_incomplete_tasks

  when "remove"
    idx = task_list.ask_for_task("remove")
    task = task_list.get_task(idx)

    task_list.remove_task(idx)

    puts "\n'#{task.title}' has been removed"

  when "thread"
    kick_off_threads

  when "factorial"
    # calculate the factorial of every number from 1 to 20, 10! times. Repeat this 10 times to find the average
    sum, result = 0, 0
    (1..10).each do
      start_time = Time.now

      (1..3628800).each do
        (1..20).each do |i|
          result = factorial(i)
        end
      end

      end_time = Time.now
      sum += end_time - start_time
    end
    avg_execution_time = sum / 10

    puts "\nFactorial result: #{result}"
    puts "Average execution time: #{avg_execution_time * 1000} milliseconds"
  else
    puts "Invalid action"
  end
end
