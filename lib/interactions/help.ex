defmodule Timezoner.Interactions.Help do
  use Larabot.Interaction.Help

  alias Larabot.Component

  @impl Larabot.Interaction.Help
  def title, do: "Timezoner"

  @impl Larabot.Interaction.Help
  def description, do: "I let you send times and dates that everyone sees in their own timezone."

  @impl Larabot.Interaction.Help
  def components,
    do: [convert_container(), date_container(), copy_container(), user_time_container()]

  @impl Larabot.Interaction.Help
  def homepage, do: "https://timezoner.lara.lv"

  def convert_container do
    Component.container([
      Component.text("### Convert a time or date in a message"),
      Component.text(
        "When there's a time in a message, the bot will add a reaction to it. Simply hit that reaction and everyone magically sees the time in their own timezone."
      ),
      Component.text(
        "-# Only the person that sent the message needs to set their timezone, the ones reading the time don't even need to do anything."
      ),
      Component.media_gallery([
        "https://cdn.lara.lv/timezoner/help/placeholder-example.png"
      ])
    ])
  end

  def date_container do
    Component.container([
      Component.text("### Send a time or date"),
      Component.text("You can also send a time or date directly by using the command `/date`."),
      Component.text("-# You can style it too, showing just the date for example."),
      Component.media_gallery([
        "https://cdn.lara.lv/timezoner/help/placeholder-example.png"
      ])
    ])
  end

  def copy_container do
    Component.container([
      Component.text("### Share in DMs or another server"),
      Component.text(
        "Open the menu on a message and select *Copy Text* to share a time or date anywhere."
      ),
      Component.text(
        "-# You can even use this in your bio, maybe to show what your noon is to others."
      ),
      Component.media_gallery([
        "https://cdn.lara.lv/timezoner/help/placeholder-example.png"
      ])
    ])
  end

  def user_time_container do
    Component.container([
      Component.text("### Learn what time it is for someone"),
      Component.text(
        "Want to know if your friend is asleep for example? Well, you can by opening the menu on a user and choosing *Apps -> Get Current Time*."
      ),
      Component.text("-# Just remember that the other user needs to set their timezone first."),
      Component.media_gallery([
        "https://cdn.lara.lv/timezoner/help/placeholder-example.png"
      ])
    ])
  end
end
