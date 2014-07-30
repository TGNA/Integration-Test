require 'spec_helper'

describe ConnectionDiagnostic do

  # perform_diagnostic
  # disconnects the client
  # tries to connect the client 3 times
  # if unsuccessful raise Error
  # if successful sends 'AT#UD' to client (diagnostic message)
  #   and receives from the client the diagnostic info
  #   this info should be accesible on the attribute info

  it "disconects the client" do
    client = Client.new
    expect(ConnectionDiagnostic.new(client).disconects_client).to eq(false) 
  end

  it "tries to connect the client 1 time and fails" do
    @client = double("client")
    @client.stub(:connect).and_return(false)
    @client.should_receive(:connect).and_return (false) 
    expect(ConnectionDiagnostic.new(@client).perform_diagnostic).to eq(false)  
  end

  it "tries to connect the client 1 time and get successful" do
    @client = double("client")
    @client.stub(:connect).and_return(true)
    expect(ConnectionDiagnostic.new(@client).perform_diagnostic).to eq('AT#UD')  
  end

  it "tries to connect three times and fails" do
    @client = double("client")
    @client.stub(:connect).and_return(false)
    cd = ConnectionDiagnostic.new(@client)
    cd.perform_diagnostic
    cd.perform_diagnostic
    expect(cd.perform_diagnostic).to raise_error("Error")
    # expect(cd.perform_diagnostic).to eq("Error Raised")
  end

end