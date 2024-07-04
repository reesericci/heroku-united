class Export::CSV < Export
  def to_data
    @relation.to_csv
  end
end
