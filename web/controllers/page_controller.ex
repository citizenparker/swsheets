defmodule EdgeBuilder.PageController do
  use EdgeBuilder.Web, :controller

  alias EdgeBuilder.Models.User
  alias EdgeBuilder.Models.Character
  alias EdgeBuilder.Repo
  import Ecto.Query, only: [from: 2]

  plug :action

  def index(conn, params) do
    page = Repo.paginate((from c in Character, order_by: [desc: :inserted_at], limit: 30), page: params["page"], page_size: 5)

    render conn, :index,
      contributors: User.contributors(5),
      characters: page.entries,
      page_number: page.page_number,
      total_pages: page.total_pages,
      has_reset_password: get_flash(conn, :has_reset_password)
  end

  def thanks(conn, _params) do
    render conn, :thanks,
      pull_requesters: User.pull_requesters,
      bug_reporters: User.bug_reporters
  end

  def about(conn, _params) do
    render conn, :about
  end
end
