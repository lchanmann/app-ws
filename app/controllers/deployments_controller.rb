class DeploymentsController < ApplicationController
  
  def current_queries
    @queries = current_deployment.current_queries
  end

end
