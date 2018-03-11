defmodule Fixtures do
  def create_user(admin \\ false) do
    user_params = %{
      username: "user_#{:erlang.unique_integer([:positive, :monotonic])}",
      password: "hunter2",
      is_admin: admin
    }

    GQLardian.Accounts.create_user(user_params)
  end

  @post_params %{
    title: "Lorem Ipsum",
    content:
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis sapien lectus, blandit ac tortor vel, pulvinar iaculis mi. Nunc ante massa, tincidunt a rutrum in, suscipit non justo. Maecenas ut enim nunc. Aliquam malesuada fermentum turpis. Mauris congue blandit pretium. Aliquam sit amet imperdiet lacus. Sed faucibus sed odio in ultricies. Nunc vel vulputate ex. Phasellus maximus luctus auctor. Vivamus neque metus, consequat at scelerisque sit amet, ullamcorper eu nisi."
  }

  def create_post() do
    post_params = GQLardian.Posts.create_post(@post_params)
  end

  def post_params() do
    @post_params
  end
end
