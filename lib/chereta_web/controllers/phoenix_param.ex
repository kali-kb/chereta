defimpl Phoenix.Param, for: Chereta.Schemas.Category do
  def to_param(%Chereta.Schemas.Category{category_id: category_id}) do
    Integer.to_string(category_id)
  end
end

defimpl Phoenix.Param, for: Chereta.Schemas.Bid do
  def to_param(%Chereta.Schemas.Bid{bid_id: bid_id}) do
    Integer.to_string(bid_id)
  end
end
