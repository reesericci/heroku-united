class Export::OpenSlides < Export
  def to_data
    @relation.to_csv spreadsheet_columns: ->(m) do
      [
        :username,
        :name,
        :email
      ]
    end
  end
end
