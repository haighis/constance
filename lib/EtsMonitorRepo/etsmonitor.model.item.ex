# defmodule EtsMonitor.Model.Item do
#   use EtsMonitor.Model
#   @primary_key {:monitor_id, :binary_id, autogenerate: true}
#   schema "monitors" do
#     field :name, :string
#     field :type, :string
#     field :interval, :string
#     field :details, :string
#   end

#   def changeset(params \\ %{}) do
#     changeset(%__MODULE__{}, params)
#   end

#   def changeset(model, params) do
#     fields = __MODULE__.__schema__(:fields)
#     embeds = __MODULE__.__schema__(:embeds)
#     cast_model = cast(model, params, fields -- embeds)

#     Enum.reduce(embeds, cast_model, fn embed, model ->
#       cast_embed(model, embed)
#     end)
#   end
# end