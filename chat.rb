# Write your solution here!

require "openai"
require "dotenv/load"
require "http"
require "json"

client = OpenAI::Client.new(access_token: ENV.fetch("GPT_KEY"))
count = 0
puts "Hello! How can I help you today?"
message_list = [
  {
    "role" => "system",
    "content" => "You are a helpful assistant."
  },
]

while count< 1

  puts  "--------------------------------------------------" 
  user_loc = gets.chomp 

  if user_loc.strip.downcase == "bye" 
    count= count + 1
  else
    message_list.push({"role" => "user", "content" => user_loc.to_s})

    # Call the API to get the next message from GPT
    api_response = client.chat(
      parameters: {
        model: "gpt-3.5-turbo",
        messages: message_list
      }
    )

    choices = api_response.fetch("choices")
    array1 = choices.at(0)
    messages_api=array1.fetch("message")
    content = messages_api.fetch ("content")
    puts content
    message_list.push({ "role" => "assistant", "content" => content })
    
  end

end
