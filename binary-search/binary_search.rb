class BinarySearch
  # Basic binary search for a sorted array
  # Returns the index of the target if found, or nil if not found
  def self.search(arr, target)
    raise ArgumentError, "Input must be a sorted array" unless sorted?(arr)

    left = 0
    right = arr.length - 1

    while left <= right
      mid = left + (right - left) / 2

      case target <=> arr[mid]
      when 0
        return mid  # Target found
      when 1
        left = mid + 1  # Target is in the right half
      when -1
        right = mid - 1  # Target is in the left half
      end
    end

    nil  # Target not found
  end

  # Recursive implementation of binary search
  def self.recursive_search(arr, target, left = 0, right = nil)
    raise ArgumentError, "Input must be a sorted array" unless sorted?(arr)

    right = arr.length - 1 if right.nil?

    # Base case: element not found
    return nil if left > right

    mid = left + (right - left) / 2

    case target <=> arr[mid]
    when 0
      mid  # Target found
    when 1
      # Target is in the right half
      recursive_search(arr, target, mid + 1, right)
    when -1
      # Target is in the left half
      recursive_search(arr, target, left, mid - 1)
    end
  end

  # Find the first occurrence of a target in a sorted array with duplicates
  def self.find_first_occurrence(arr, target)
    raise ArgumentError, "Input must be a sorted array" unless sorted?(arr)

    left = 0
    right = arr.length - 1
    result = nil

    while left <= right
      mid = left + (right - left) / 2

      if target == arr[mid]
        result = mid  # Potentially the first occurrence
        right = mid - 1  # Continue searching in the left half
      elsif target < arr[mid]
        right = mid - 1
      else
        left = mid + 1
      end
    end

    result
  end

  # Find the last occurrence of a target in a sorted array with duplicates
  def self.find_last_occurrence(arr, target)
    raise ArgumentError, "Input must be a sorted array" unless sorted?(arr)

    left = 0
    right = arr.length - 1
    result = nil

    while left <= right
      mid = left + (right - left) / 2

      if target == arr[mid]
        result = mid  # Potentially the last occurrence
        left = mid + 1  # Continue searching in the right half
      elsif target < arr[mid]
        right = mid - 1
      else
        left = mid + 1
      end
    end

    result
  end

  # Count occurrences of a target in a sorted array
  def self.count_occurrences(arr, target)
    first = find_first_occurrence(arr, target)
    return 0 if first.nil?

    last = find_last_occurrence(arr, target)
    last - first + 1
  end

  # Check if the array is sorted in ascending order
  def self.sorted?(arr)
    arr == arr.sort
  end
end

# Example usage and demonstration
def demonstrate_binary_search
  puts "Binary Search Demonstration"
  puts "------------------------"

  # Test array
  arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

  # Demonstrate different search methods
  puts "Array: #{arr}"

  # Basic search
  puts "\nBasic Search:"
  target = 7
  index = BinarySearch.search(arr, target)
  puts "#{target} found at index: #{index}"

  # Recursive search
  puts "\nRecursive Search:"
  target = 4
  index = BinarySearch.recursive_search(arr, target)
  puts "#{target} found at index: #{index}"

  # Array with duplicates
  dup_arr = [1, 2, 2, 2, 3, 4, 4, 5, 5, 5, 6]
  puts "\nArray with Duplicates: #{dup_arr}"

  # First and last occurrence
  target = 2
  first_index = BinarySearch.find_first_occurrence(dup_arr, target)
  last_index = BinarySearch.find_last_occurrence(dup_arr, target)
  occurrences = BinarySearch.count_occurrences(dup_arr, target)

  puts "First occurrence of #{target}: index #{first_index}"
  puts "Last occurrence of #{target}: index #{last_index}"
  puts "Total occurrences of #{target}: #{occurrences}"

  # Error handling
  begin
    unsorted_arr = [5, 3, 1, 4, 2]
    BinarySearch.search(unsorted_arr, 3)
  rescue ArgumentError => e
    puts "\nError Handling:"
    puts "Attempted to search unsorted array - #{e.message}"
  end
end

# Run the demonstration
demonstrate_binary_search
