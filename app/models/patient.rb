class Patient < ActiveRecord::Base
  attr_accessible :address, :dateOfBirth, :email, :ethnicity, :firstName, :gender, :identificationNumber, :lastName, :mobileNumber, :notes, :phoneNumber
end
