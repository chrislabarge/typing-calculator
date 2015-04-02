# By default Volt generates this controller for your Main component
class MainController < Volt::ModelController

	def index
    # Add code for when the index view is loaded
  end

  def about
    # Add code for when the about view is loaded
  end

	def sample_text
   "In Volt, to simplify managing application state, all application state is kept in models that can optionally be persisted in different locations. By centralizing the application state, we reduce the amount of complex code needed to update a page. We can then build our page's html declaratively."
  end

  def sample_array
   sample_text.split
  end

  def user_array
  	page._user_string.split
  end

  def mistakes_array
  	popped_array = user_array
  	popped_array.pop
  	mistakes = popped_array - sample_array
  end

  def character_length(array)
  	array.join.length
  end

	def accuracy
  	correct_characters = character_length(user_array) - character_length(mistakes_array)
  	fraction = correct_characters/ character_length(user_array)
  	accuracy_percentage = (fraction * 100).round
	end

	def word_num
 		character_length(user_array) / 5
	end

	def time_elapsed
 		if page._user_string.length == 1
    	@start_time = Time.new
 		elsif page._user_string.length == 0
    	@start_time = 0
    else
  	 nil
  	end

 		seconds = (Time.now - @start_time).round / 60
	end

 	def gross_wpm
 		(word_num / time_elapsed).round
  end

 	def net_wpm
  	errors_per_min = (mistakes_array.count / time_elapsed).round
  	gross_wpm - errors_per_min
	end

	def accuracy_rounded #nearest multiple of 5 for the progress circle
		((((accuracy / 10) * 2).round) / 2) * 10
	end

 private

  # The main template contains a #template binding that shows another
  # template.  This is the path to that template.  It may change based
  # on the params._controller and params._action values.
  def main_path
    params._controller.or('main') + '/' + params._action.or('index')
  end

  # Determine if the current nav component is the active one by looking
  # at the first part of the url against the href attribute.
  def active_tab?
    url.path.split('/')[1] == attrs.href.split('/')[1]
  end
end
