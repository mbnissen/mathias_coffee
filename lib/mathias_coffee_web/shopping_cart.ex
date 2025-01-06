defmodule MathiasCoffeeWeb.ShoppingCart do
  @initial_state %{
    items: []
  }

  alias MathiasCoffee.Inventory

  def init(session) do
    {_, cache} = Cachex.get(:my_cache, session["_csrf_token"])

    if(!cache) do
      Cachex.put(:my_cache, session["_csrf_token"], @initial_state)
    end
  end

  def clearCache do
    Cachex.clear(:my_cache)
  end

  def get_items(session) do
    {_, cache} = Cachex.get(:my_cache, session["_csrf_token"])
    cache.items
  end

  def decrement_item_in_cart(id, token) do
    {_, cache} = Cachex.get(:my_cache, token)

    mod_items =
      Enum.map(
        cache.items,
        fn item ->
          if item.id === String.to_integer(id) do
            %{item | count: item.count - 1}
          else
            item
          end
        end
      )

    after_remove =
      Enum.filter(
        mod_items,
        fn item ->
          item.count !== 0
        end
      )

    cache = Map.put(cache, :items, after_remove)
    Cachex.put(:my_cache, token, cache)
    after_remove
  end

  def increment_item_in_cart(id, token) do
    {_, cache} = Cachex.get(:my_cache, token)
    items = cache.items

    filtered_item =
      Enum.filter(
        items,
        fn item ->
          item.id === id
        end
      )

    coffee = Inventory.get_coffee!(id)
    filtered_item

    concat_items =
      if Enum.count(filtered_item) === 0 do
        [%{id: id, count: 0, coffee: coffee}]
      else
        []
      end

    items = items ++ concat_items

    items =
      Enum.map(items, fn item ->
        if item.id == id do
          %{item | count: item.count + 1}
        else
          item
        end
      end)

    cache = Map.put(cache, :items, items)
    Cachex.put(:my_cache, token, cache)
    items
  end

  def delete_item_from_cart(id, token) do
    {_, cache} = Cachex.get(:my_cache, token)

    mod_items =
      Enum.filter(cache.items, fn item ->
        item.id != id
      end)

    cache = Map.put(cache, :items, mod_items)
    Cachex.put(:my_cache, token, cache)
    mod_items
  end
end
