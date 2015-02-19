require 'Benchmark'
require_relative '../../../../Documents/coding_data/bury_my_ruby/app_acad/AA_final_coding_challenge'
require_relative 'sorts'
# stock_generator takes (start_price, number_of_days)

class MethodBenchmarker
	def initialize(object, methods)
		@object, @methods = object, methods
	end

	def print_report
		Benchmark.bmbm do |x|
			@methods.each do |method|
			  x.report("#{method.to_s}") { @object.send(method) }
			end
		end
	end

	def print_answer
		@methods.each do |method|
			print "#{method.to_s} answer is #{ @object.send(method) }"; puts
		end
	end

	def print_all
		print_report; puts
		print_answer; puts
	end
end

class FunctionBenchmarker
	def initialize(object, methods)
		@object, @methods = object, methods
	end

	def print_report
		Benchmark.bmbm do |x|
			@methods.each do |meth|
			  x.report("#{meth.to_s}") { nil.method(meth).call(@object) }
			end
		end
	end

	def print_answer
		@methods.each do |meth|
			print "#{meth.to_s} answer is #{ nil.method(meth).call(@object) }"; puts
		end
	end

	def print_all
		print_report; puts
		print_answer; puts
	end
end

# arr = stock_generator(500, 10000)
arr = []; 5000.times { arr << rand(10000) }
methods = [:bubble_sort, :merge_sort, :quick_sort]#, :selection_sort]
bm = FunctionBenchmarker.new(arr, methods)
bm.print_report

bm2 = MethodBenchmarker.new(arr, [:sort])
bm2.print_report

