require "arb/thread/version"

module Arb
  module Thread
    #Simple thread pool.
    class TaskDispatcher
      def initialize(max_thread_count)
        @assist_mutex=Mutex.new
        @task_mutex=Mutex.new
        @max_thread_count=max_thread_count
        @current_thread_count=0
      end

      def task_sync
        @task_mutex.synchronize do
          yield
        end
      end

      def task_start(&blk)
        @current_thread_count+=1
        ::Thread.new do
          begin
            blk[@assist_mutex]
          rescue Exception=>e
            puts e
          ensure
            task_end
          end
        end
      end

      def task_end
        task_sync do
          @current_thread_count-=1
        end
      end

      def available
        task_sync do
          @current_thread_count
        end
      end

      def new_task(refresh_delay=0.2, &blk)
        return nil unless blk
        break_loop=false
        loop do
          task_sync do
            if @current_thread_count<@max_thread_count
              break_loop=true
              task_start(&blk)
            end
          end
          break if break_loop
          sleep refresh_delay
        end
      end
      private :task_sync,:task_start,:task_end
    end

    class << ::Thread
      define_method :parallel do |max_thread_count,&blk|
        TaskDispatcher.new(max_thread_count).tap do |dispatcher|
          blk[dispatcher]
        end
      end
    end
  end
end
