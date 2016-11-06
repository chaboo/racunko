def fixture(filename)
  File.new(Rails.root.join("spec/fixtures", filename)).read
end

def load_fixture(filename)
  JSON.parse(fixture("#{filename}.json"))
end
