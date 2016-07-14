require 'csv'

class StatementsController < ApplicationController
  def new
  end

  def create
    results = []
    csv = CSV.parse(params[:statement][:file].read, :headers => true)
    csv.each do |row|
      row = row.to_hash.with_indifferent_access
      results << row.to_hash.symbolize_keys
      results << row.inspect
    end


    render :text => results
  end
end
