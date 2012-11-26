class WelcomeController < ApplicationController
   def send_instuctions
    send_to  =  params['send_to'].gsub("(","").gsub("-","").gsub(")","").gsub(" ","")
      if send_to.length == 10
        response = Response.create(to: send_to, body: Response.text_instructions)
        response.transmit
        notice = "okay hang tight, instructions are on the way"
      end
    redirect_to root_path, :notice => notice || "sorry, I cant figure out how to text #{params['send_to']}"
  end
end

