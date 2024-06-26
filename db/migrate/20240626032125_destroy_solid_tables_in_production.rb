class DestroySolidTablesInProduction < ActiveRecord::Migration[7.2]
  def change
    # standard:disable Rails/ReversibleMigration
    drop_table :solid_cache_entries, force: true

    drop_table :solid_queue_jobs, force: true
    drop_table :solid_queue_scheduled_executions, force: true
    drop_table :solid_queue_ready_executions, force: true
    drop_table :solid_queue_claimed_executions, force: true
    drop_table :solid_queue_blocked_executions, force: true
    drop_table :solid_queue_failed_executions, force: true
    drop_table :solid_queue_recurring_executions, force: true
    drop_table :solid_queue_pauses, force: true
    drop_table :solid_queue_processes, force: true
    drop_table :solid_queue_semaphores, force: true

    drop_table :solid_cable_messages, force: true
    # standard:enable Rails/ReversibleMigration
  end
end
