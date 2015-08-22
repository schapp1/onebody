class ImportExecutionJob < ActiveJob::Base
  queue_as :import

  def perform(site, import_id)
    ActiveRecord::Base.connection_pool.with_connection do
      Site.with_current(site) do
        import = Import.find(import_id)
        ImportExecution.new(import).execute
      end
    end
  end
end
