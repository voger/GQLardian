defmodule  GQLardianWeb.Schema.ValidationMessageTypes do
  @moduledoc """
  This contains absinthe objects used in mutation responses.

  To use, import into your Absinthe.Schema files with

  ```
  import_types GQLardianWeb.Schema.ValidationMessageTypes
  ```

  ## Objects

  :validation_message contains some of the fields included in a `Kronky.ValidationMessage` for maximum flexibility.

  The `:template` and `:options` fields are removed.

  ```elixir
  object :validation_message, description: "..." do
  field :field, :string, description: "..."
  field :message, :string, description: "..."
  field :code, non_null(:string), description: "..."
  end
  ```

  Actual descriptions have been ommited for brevity - check the github repo to see them.
  """
  use Absinthe.Schema.Notation

  #simplify access to reusable descriptions
  @descs %{
    validation_message: """
    Validation messages are returned when mutation input does not meet the requirements.
    While client-side validation is highly recommended to provide the best User Experience,
    All inputs will always be validated server-side.

    Some examples of validations are:

    * Username must be at least 10 characters
    * Email field does not contain an email address
    * Birth Date is required

    While GraphQL has support for required values, mutation data fields are always
    set to optional in our API. This allows 'required field' messages
    to be returned in the same manner as other validations. The only exceptions
    are id fields, which may be required to perform updates or deletes.
    """  ,
    field: "The input field that the error applies to. The field can be used to
    identify which field the error message should be displayed next to in the
    presentation layer.

    If there are multiple errors to display for a field, multiple validation
    messages will be in the result.

    This field may be null in cases where an error cannot be applied to a specific field.
    ",
    message: "A friendly error message, appropriate for display to the end user.

    The message is interpolated to include the appropriate variables.

    Example: `Username must be at least 10 characters`

    This message may change without notice, so we do not recommend you match against the text.
    Instead, use the *code* field for matching.",

    successful: "Indicates if the mutation completed successfully or not. ",
    code: "A unique error code for the type of validation used.",
  }

  object :validation_message, description: @descs.validation_message do
    field :field, :string, description: @descs.field
    field :message, :string, description: @descs.message
    field :code, non_null(:string), description: @descs.code
    # field :template, :string, description: @descs.template
    # field :options, list_of(:validation_option), description: @descs.option_list
  end

end
