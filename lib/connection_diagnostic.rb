require 'client'
require 'pry'

class ConnectionDiagnostic
  # perform_diagnostic
 	 # disconnects the client
  	# tries to connect the client 3 times
  	# if unsuccessful raise Error
  	# if successful sends 'AT#UD' to client (diagnostic message)
  	#   and receives from the client the diagnostic info
  	#   this info should be accesible on the attribute info



  def initialize(client)
  	@counter = 0 
  	@client = client
  end

  def perform_diagnostic
  	# disconects_client
  	connects_client
  end
  
  def disconects_client
  	@client.disconnect
  end

  def connects_client
  	answer = false
  	if @client.connect
			'AT#UD'
		else 
			@counter += 1
			if @counter >= 2
				raise "Error"
			end
			answer
		end
  end

  connects_client rescue "Error Raised"
end
