class Array

  def insertion_sort
    self.dup.insertion_sort!
  end

  def insertion_sort!
    self.each_with_index do |el, i|
      j = i - 1
      while j >= 0
        break if self[j] <= el
        self[j + 1] = self[j]
        j -= 1
      end
        self[j + 1] = el
    end

    self
  end

  def selection_sort
    self.dup.selection_sort!
  end

  def selection_sort!
    last_idx = self.length - 1

    self.count.times do |i|
      smaller_idx = i
      (i + 1).upto(last_idx) do |j|
        smaller_idx = j if self[j] < self[smaller_idx]
      end

      self[i], self[smaller_idx] = self[smaller_idx], self[i]
    end

    self
  end

  def bubble_sort
    self.dup.bubble_sort!
  end

  def bubble_sort!
    sorted = false

    until sorted
      sorted = true
      (self.count - 1).times do |i|
        if self[i] > self[i + 1]
          self[i], self[i + 1] = self[i + 1], self[i]
          sorted = false
        end
      end
    end

    self
  end

  def merge_sort
    self.dup.merge_sort!
  end

  def merge_sort!
    return self if self.length < 2
    
    median = self.length / 2
    sorted_left = self[0...median].merge_sort!
    sorted_right = self[median..-1].merge_sort!

    merge_subarrays(sorted_left, sorted_right)
  end

  def merge_subarrays(sorted_left, sorted_right)
    merged_arr = []

    until sorted_left.empty? || sorted_right.empty?
      left_el_smaller = (sorted_left.first < sorted_right.first)
      merged_arr << ((left_el_smaller) ? sorted_left.shift : sorted_right.shift )
    end

    merged_arr + sorted_left + sorted_right
  end

  def quick_sort
    self.dup.quick_sort!
  end

  def quick_sort!
    return self if self.length < 2

    pivot_index = Random.rand(self.length)
    pivot = self[pivot_index]

    left = self.find_all { |x| x < pivot }
    equal = self.find_all { |x| x == pivot }
    right = self.find_all { |x| x > pivot }

    left.quick_sort! + equal + right.quick_sort!
  end

end