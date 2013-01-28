shared_examples_for "accessed from anonymous users" do
  it "should denial access" do
    expect(JSON.parse(response.body)["success"]).to be_false
    response.response_code.should == 401
  end
end
