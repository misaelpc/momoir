defmodule Momoir.NotificationStore do
  use Mnesiac.Store
  import Record, only: [defrecord: 3]
  require Logger
  defrecord(
    :notification,
    :notifications,
    reference: nil,
    message: nil
   )
  @type notification ::
           record(
             :notification,
             reference: String.t(),
             message: String.t()
           )
   @impl true
   def store_options do
   [
       record_name: :notification,
       attributes: notification() |> notification() |> Keyword.keys(),
       index: [],
       disc_copies: [node()]
     ]
  end
 end
