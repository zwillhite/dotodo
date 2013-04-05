module Api
  module V1
    class TasksController < ApplicationController
      
      respond_to :json
      
      def index
        haveItems = params[:ids]
        catItem = params[:catid]
        
        if haveItems == nil && catItem == nil
          respond_with Task.all
        elsif haveItems != nil
          respond_with Task.where('id IN (?)', haveItems)
        elsif catItem != nil
          respond_with Task.where('category_id = ?', catItem)
        end
        
      end
      
      def complete
        @task = Task.find(params[:id])
        @task.completion_date = Time.zone.now
        
        respond_to do |format|
          if @task.update_attributes(params[:task])
            format.html { redirect_to @task, notice: 'Task was successfully updated.' }
            format.json { head :no_content }
          else
            format.html { render action: "edit" }
            format.json { render json: @task.errors, status: :unprocessable_entity }
          end
        end
      end
    end
  end
end