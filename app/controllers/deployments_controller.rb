class DeploymentsController < ApplicationController
  
  def current_queries
    @queries = current_deployment.current_queries

    respond_to do |format|
      format.html
      format.js
    end
  end

end
