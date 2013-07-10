class DictionariesController < ApplicationController
  before_action :set_dictionary, only: [:show]

  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dictionary
      @dictionary = Dictionary.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dictionary_params
      params.require(:dictionary).permit(:word)
    end
end
