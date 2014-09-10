require 'cy_data/unknown_file_type_exception'
require 'cy_data/file_reader'
require 'cy_data/file_writer'
require 'cy_data/comparator/date_of_birth'
require 'cy_data/comparator/last_name'
require 'cy_data/comparator/gender_last_name'

module CyData
  
  # class UnknownFileTypeException < Exception; 
  
  def self.process(files)
    records = import_files(files)
    output(records)
  end
  
  def self.import_files(files)
    records = []
    files.each do |file|
      records.concat(import_file(file))
    end
    
    records
  end
  
  def self.import_file(file)
    if piped_file?(file)
      import_piped_file
    elsif comma_file?(file)
      import_comma_file(file)
    elsif space_file?(file)
      import_space_file
    else
      raise UnknownFileTypeException, "File type is unknown for file: #{file}"
    end
  end
  
  def self.piped_file?(file)
    File.basename(file, ".txt").downcase == "pipe"
  end
  
  def self.comma_file?(file)
    File.basename(file, ".txt").downcase == "comma"
  end
  
  def self.space_file?(file)
    File.basename(file, ".txt").downcase == "space"
  end
  
  def self.import_piped_file(file)
    reader = FileReader.new(file: file,
                            delimiter: '|',
                            fields: [:last_name, :first_name, :middle_initial, :gender, :favorite_color, [:date_of_birth, Date]])
    reader.import
  end
  
  def self.import_comma_file(file)
    reader = FileReader.new(file: file,
                            delimiter: ',',
                            fields: [:last_name, :first_name, :gender, :favorite_color, [:date_of_birth, Date]])
    reader.import
  end
  
  def self.import_space_file(file)
    reader = FileReader.new(file: file,
                            delimiter: /\s+/,
                            fields: [:last_name, :first_name, :middle_initial, :gender, [:date_of_birth, Date], :favorite_color])
    reader.import
  end
  
  def self.output(records=[])
    return if records.empty?
    
    output_format = lambda 

    writer = FileWriter.new(records) do |record|
      dob = record.date_of_birth.format('M/D/YYYY')
      [record.last_name, record.first_name, record.gender, record.middle_initial, dob, record.favorite_color]
    end
    
    # writer.write # ouputs the records unsorted
    writer.write(sorter: Comparator::GenderLastName, header: "Output 1:")
    writer.write(sorter: Comparator::DateOfBirth, header: "Output 1:")
    writer.write(sorter: Comparator::LastName, header: "Output 1:")
  end
end