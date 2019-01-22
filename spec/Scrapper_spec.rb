#spec cityhalls

describe "the cityhallo_scrapper method" do
    it "should return an array" do
      expect(cityhall_scrapper).to be_an_instance_of(Array)
    end
    it "should return a not empty array" do
      expect(cityhall_scrapper).not_to be_empty
    end
  
    it "should return the first city" do
      A=cityhall_scrapper()
      expect(A[0].keys[0]).to eq("ABLEIGES")
    end
    it "should return mairie.ableiges95@wanadoo.fr" do
      A=cityhall_scrapper()
      expect(A[0].values_at("ABLEIGES")[0]).to eq("mairie.ableiges95@wanadoo.fr")
    end
  end