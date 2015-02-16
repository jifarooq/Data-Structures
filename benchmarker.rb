require 'Benchmark'
require_relative '../../Documents/coding_data/bury_my_ruby/app_acad/AA_final_coding_challenge'
require_relative 'trash'
# stock_generator takes (start_price, number_of_days)

class MethodBenchmarker
	def initialize(object, method1, method2)
		@object, @method1, @method2 = object, method1, method2
	end

	def print_report
		Benchmark.bmbm do |x|
		  x.report("#{@method1.to_s}") { @object.send(@method1) }
			x.report("#{@method2.to_s}") { @object.send(@method2) }
		end
	end

	def print_answer
		print "#{@method1.to_s} answer is #{ @object.send(@method1) }"; puts
		print "#{@method2.to_s} answer is #{ @object.send(@method2) }"; puts
	end

	def print_all
		print_report; puts
		print_answer; puts
	end
end

class FunctionBenchmarker
	def initialize(object, method1, method2)
		@object, @method1, @method2 = object, method1, method2
	end

	def print_report
		Benchmark.bmbm do |x|
		  x.report("#{@method1.to_s}") { nil.method(@method1).call(@object) }
			x.report("#{@method2.to_s}") { nil.method(@method2).call(@object) }
		end
	end

	def print_answer
		print "#{@method1.to_s} answer is #{ nil.method(@method1).call(@object) }"; puts
		print "#{@method2.to_s} answer is #{ nil.method(@method2).call(@object) }"; puts
	end

	def print_all
		print_report; puts
		print_answer; puts
	end
end

arr = stock_generator(500, 1000000)
rand_num = arr[ rand(arr.size) ]
args = [arr, rand_num]

bm = FunctionBenchmarker.new(args, :next_larger_slow, :next_larger_fast)
bm.print_all

