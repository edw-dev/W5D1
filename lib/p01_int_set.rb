class MaxIntSet
  attr_accessor :store, :max
  def initialize(max)
    @max = max
    @store = Array.new(max,false)
  end

  def insert(num)
    if num >= 0 && num < max
      @store[num] = true
    else
      raise "Out of bounds"
    end end

  def remove(num)
    @store[num] = false
  end

  def include?(num)
    @store[num] 
  end

  private

  def is_valid?(num)
  end

  def validate!(num)
  end
end


class IntSet
  attr_accessor :store, :num_buckets
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num] << num
  end

  def remove(num)
    self[num].delete_at(self[num].index(num))
  end

  def include?(num)
    self[num].any?{|ele| ele == num}
  end

  private

  def [](num)
    @store[num%num_buckets]
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_accessor :store, :num_buckets, :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    resize! if @count == @store.length 
    self[num] << num if self[num].empty? || self[num].none? { |ele| ele == num } 
  end

  def remove(num)
    index = self[num].index(num)
    self[num].delete_at(index) unless index.nil?
  end

  def include?(num)
    self[num].include?(num)
  end

  def count
    @store.flatten.length
  end

  private

  def [](num)
    @store[num%num_buckets]
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    #if self.count >= @store.length
      storage = []
      @store.each do |subs|
        until subs.empty?
          storage << subs.pop
        end
      end
      # num_buckets
      @store = Array.new(@store.length * 2) {Array.new}
      storage.each do |ele|
        new_idx = ele % num_buckets
        @store[new_idx] << ele
      end
    #end
  end
end
