defmodule Ecx.Entity.PromotionTest do
  use ExUnit.Case
  doctest Ecx

  alias Ecx.Entity.{Promotion}
  require IEx

  test "newはPromotionEntityを作成する" do
    code = "NEWUSER"
    promotion1 = Promotion.new("new-user", "description", code)
    assert promotion1.code == code

    start_at = Timex.now() |> Timex.to_datetime()
    end_at = Timex.now() |> Timex.to_datetime() |> Timex.shift(days: 1)
    promotion2 = Promotion.new("new-user", "description", start_at, end_at, code, [])
    assert promotion2.start_at == start_at
    assert promotion2.end_at == end_at
    assert promotion2.code == code
  end
end
