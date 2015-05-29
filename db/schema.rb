# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150524163150) do

  create_table "api_access", primary_key: "access_id", force: :cascade do |t|
    t.string "api_key",   limit: 64, null: false
    t.string "api_token", limit: 64, null: false
    t.string "status",    limit: 7,  null: false
  end

  create_table "block_ips", force: :cascade do |t|
    t.string  "blocked_ip", limit: 50, null: false
    t.string  "added_at",   limit: 50, null: false
    t.integer "reason",     limit: 4,  null: false
  end

  create_table "blocks", primary_key: "block_id", force: :cascade do |t|
    t.string  "block_title",      limit: 255,                   null: false
    t.string  "block_type",       limit: 9,                     null: false
    t.text    "block_content",    limit: 65535
    t.text    "block_component",  limit: 65535
    t.string  "block_menu_group", limit: 60
    t.string  "block_position",   limit: 8,                     null: false
    t.integer "block_order",      limit: 2,     default: 1,     null: false
    t.boolean "published",        limit: 1,     default: true,  null: false
    t.boolean "frontpage",        limit: 1,     default: false, null: false
  end

  create_table "carets_offset", primary_key: "offset_id", force: :cascade do |t|
    t.string   "param",       limit: 20, null: false
    t.integer  "value",       limit: 4,  null: false
    t.datetime "last_update",            null: false
  end

  create_table "carets_photos", primary_key: "photo_id", force: :cascade do |t|
    t.string  "url",         limit: 255,             null: false
    t.integer "matrix_id",   limit: 4,   default: 0, null: false
    t.integer "property_id", limit: 4,               null: false
    t.integer "photo_order", limit: 2
    t.string  "server",      limit: 120
  end

  add_index "carets_photos", ["matrix_id"], name: "matrix_id", using: :btree
  add_index "carets_photos", ["property_id"], name: "property_id", using: :btree

  create_table "carets_properties", primary_key: "Propertyid", force: :cascade do |t|
    t.text     "AccessibilityFeatures",      limit: 65535
    t.decimal  "Acres",                                    precision: 9, scale: 3
    t.string   "AdNumber",                   limit: 15
    t.string   "APN",                        limit: 19
    t.text     "Appliances",                 limit: 65535
    t.string   "Area",                       limit: 50
    t.text     "Assessments",                limit: 65535
    t.text     "Association",                limit: 65535
    t.integer  "AssociationDues1",           limit: 4
    t.string   "AssociationDues1Frequency",  limit: 50
    t.integer  "AssociationDues2",           limit: 4
    t.string   "AssociationDues2Frequency",  limit: 50
    t.string   "AssociationYN",              limit: 1
    t.string   "AttachedStructure",          limit: 50
    t.integer  "BasementSqft",               limit: 4
    t.integer  "BathsFull",                  limit: 4
    t.integer  "BathsHalf",                  limit: 4
    t.integer  "BathsOqtr",                  limit: 4
    t.decimal  "BathsTotal",                               precision: 5, scale: 2
    t.integer  "BathsTqtr",                  limit: 4
    t.integer  "Bedrooms",                   limit: 4
    t.string   "BlockNumber",                limit: 4
    t.string   "BuildersName",               limit: 50
    t.string   "BuildersTractCode",          limit: 50
    t.string   "BuildersTractName",          limit: 40
    t.integer  "CDOM",                       limit: 4
    t.string   "City",                       limit: 50
    t.string   "CoLA_Board",                 limit: 50
    t.string   "CoLA_DreLicenseNumber",      limit: 20
    t.string   "CoLA_FirstName",             limit: 20
    t.string   "CoLA_LastName",              limit: 20
    t.string   "CoLA_PublicID",              limit: 30
    t.string   "CoLo_Code",                  limit: 30
    t.string   "CoLo_Name",                  limit: 30
    t.text     "CommonWalls",                limit: 65535
    t.text     "CommunityFeatures",          limit: 65535
    t.text     "ConstructionMaterials",      limit: 65535
    t.text     "Cooling",                    limit: 65535
    t.string   "CoSA_Board",                 limit: 50
    t.string   "CoSA_DreLicenseNumber",      limit: 20
    t.string   "CoSA_FirstName",             limit: 20
    t.string   "CoSA_LastName",              limit: 20
    t.string   "CoSO_Code",                  limit: 30
    t.string   "CoSO_DreLicenseNumber",      limit: 20
    t.string   "CoSO_Name",                  limit: 30
    t.string   "Country",                    limit: 50
    t.string   "County",                     limit: 50
    t.string   "CrossStreets",               limit: 30
    t.datetime "DateClosedSale"
    t.datetime "DateListingContract"
    t.datetime "DatePurchaseContract"
    t.string   "DirectionFaces",             limit: 50
    t.string   "DocumentNumber",             limit: 50
    t.string   "DOH1",                       limit: 9
    t.string   "DOH2",                       limit: 9
    t.string   "DOH3",                       limit: 9
    t.integer  "DOM",                        limit: 4
    t.text     "DoorFeatures",               limit: 65535
    t.string   "DrivingDirections",          limit: 250
    t.text     "EatingArea",                 limit: 65535
    t.string   "Elevation",                  limit: 9
    t.integer  "EntryLevel",                 limit: 4
    t.text     "EntryLocation",              limit: 65535
    t.text     "ExteriorFeatures",           limit: 65535
    t.text     "Fencing",                    limit: 65535
    t.text     "Fireplace",                  limit: 65535
    t.text     "Floor",                      limit: 65535
    t.text     "Foundation",                 limit: 65535
    t.string   "GarageAttached",             limit: 50
    t.string   "GreenBuildingCertification", limit: 50
    t.decimal  "GreenCertificationRating",                 precision: 6, scale: 2
    t.string   "GreenCertifyingBody",        limit: 50
    t.text     "GreenEnergyEfficient",       limit: 65535
    t.text     "GreenEnergyGeneration",      limit: 65535
    t.text     "GreenIndoorAirQuality",      limit: 65535
    t.text     "GreenLocation",              limit: 65535
    t.text     "GreenSustainability",        limit: 65535
    t.integer  "GreenWalkScore",             limit: 4
    t.text     "GreenWaterConservation",     limit: 65535
    t.integer  "GreenYearCertified",         limit: 4
    t.text     "Heating",                    limit: 65535
    t.text     "InteriorFeatures",           limit: 65535
    t.string   "InternetSendAddressYN",      limit: 1
    t.string   "InternetSendListingYN",      limit: 1
    t.string   "LA_Board",                   limit: 50
    t.string   "LA_DreLicenseNumber",        limit: 20
    t.string   "LA_FirstName",               limit: 20
    t.string   "LA_LastName",                limit: 20
    t.string   "LA_PublicID",                limit: 30
    t.string   "LandFeeLease",               limit: 50
    t.float    "Latitude",                   limit: 53
    t.text     "Laundry",                    limit: 65535
    t.string   "LeaseConsideredYN",          limit: 1
    t.string   "License1",                   limit: 9
    t.string   "License2",                   limit: 9
    t.string   "License3",                   limit: 9
    t.integer  "ListPrice",                  limit: 4
    t.string   "ListPriceExcludes",          limit: 250
    t.string   "ListPriceIncludes",          limit: 250
    t.string   "LO_Code",                    limit: 30
    t.string   "LO_Name",                    limit: 30
    t.float    "Longitude",                  limit: 53
    t.string   "LotDimensions",              limit: 40
    t.text     "LotFeatures",                limit: 65535
    t.string   "LotNumber",                  limit: 4
    t.integer  "LotSquareFootage",           limit: 4
    t.string   "Make",                       limit: 40
    t.integer  "Matrix_Unique_ID",           limit: 8,                             default: 0,      null: false
    t.string   "MLnumber",                   limit: 12
    t.string   "MLS_ID",                     limit: 50
    t.string   "ModelCode",                  limit: 1
    t.string   "ModelName",                  limit: 14
    t.integer  "NumberCarportSpaces",        limit: 4
    t.integer  "NumberGarageSpaces",         limit: 4
    t.integer  "NumberParkingSpaces",        limit: 4
    t.integer  "NumberRemotes",              limit: 4
    t.integer  "NumberUncoveredSpaces",      limit: 4
    t.integer  "NumberUnits",                limit: 4
    t.text     "OtherStructures",            limit: 65535
    t.text     "Parking",                    limit: 65535
    t.text     "Patio",                      limit: 65535
    t.integer  "PicCount",                   limit: 4
    t.text     "Pool",                       limit: 65535
    t.text     "PropertyDescription",        limit: 65535
    t.string   "PropertySubType",            limit: 50
    t.text     "Roofing",                    limit: 65535
    t.text     "Rooms",                      limit: 65535
    t.string   "RVAccessDimensions",         limit: 7
    t.string   "SA_Board",                   limit: 50
    t.string   "SA_DreLicenseNumber",        limit: 20
    t.string   "SA_FirstName",               limit: 20
    t.string   "SA_LastName",                limit: 20
    t.string   "SA_PublicID",                limit: 30
    t.text     "SaleType",                   limit: 65535
    t.string   "SchoolDistrict",             limit: 50
    t.string   "SchoolElementary",           limit: 20
    t.string   "SchoolHigh",                 limit: 20
    t.string   "SchoolJuniorHigh",           limit: 20
    t.text     "SecurityFeatures",           limit: 65535
    t.integer  "SellingPrice",               limit: 4
    t.string   "SeniorYN",                   limit: 1
    t.string   "SerialU",                    limit: 25
    t.string   "SerialX",                    limit: 25
    t.string   "SerialXX",                   limit: 25
    t.text     "Sewer",                      limit: 65535
    t.string   "SO_Code",                    limit: 30
    t.string   "SO_DreLicenseNumber",        limit: 20
    t.string   "SO_Name",                    limit: 30
    t.text     "Spa",                        limit: 65535
    t.string   "SqFtSourceLot",              limit: 50
    t.string   "SqFtSourceStructure",        limit: 50
    t.integer  "SquareFootageStructure",     limit: 4
    t.string   "State",                      limit: 50
    t.string   "Status",                     limit: 50
    t.string   "Stories",                    limit: 50
    t.integer  "StoriesTotal",               limit: 4
    t.string   "StreetDirection",            limit: 50
    t.string   "StreetDirectionSuffix",      limit: 50
    t.string   "StreetName",                 limit: 30
    t.integer  "StreetNumber",               limit: 4
    t.string   "StreetNumberModifier",       limit: 8
    t.string   "StreetSuffix",               limit: 50
    t.string   "StreetSuffixModifier",       limit: 15
    t.text     "StructuralCondition",        limit: 65535
    t.text     "Style",                      limit: 65535
    t.string   "ThomasGuide",                limit: 7
    t.datetime "TimestampModified"
    t.datetime "TimestampPhotoModified"
    t.string   "TractNumber",                limit: 6
    t.string   "UnitNumber",                 limit: 6
    t.text     "Utilities",                  limit: 65535
    t.text     "View",                       limit: 65535
    t.string   "VirtualTour",                limit: 255
    t.text     "WaterSource",                limit: 65535
    t.integer  "WellDepth",                  limit: 4
    t.decimal  "WellGallonsPerMinute",                     precision: 6, scale: 2
    t.decimal  "WellPumpHorsepower",                       precision: 6, scale: 2
    t.string   "WellReportYN",               limit: 1
    t.text     "WindowFeatures",             limit: 65535
    t.integer  "YearBuilt",                  limit: 4
    t.string   "YearBuiltSource",            limit: 50
    t.integer  "ZipCode",                    limit: 3
    t.string   "ZipCodePlus4",               limit: 4
    t.string   "Zone",                       limit: 40
    t.string   "AppliancesYN",               limit: 1
    t.text     "CashiersCheck",              limit: 65535
    t.string   "CoLO_DreLicenseNumber",      limit: 20
    t.string   "CoSA_PublicID",              limit: 30
    t.datetime "DateLeased"
    t.string   "Furnished",                  limit: 50
    t.string   "InsuranceWaterFurnitureYN",  limit: 1
    t.integer  "PetsAllowed",                limit: 4
    t.string   "SaleYN",                     limit: 1
    t.boolean  "PhotoImported",              limit: 1,                                              null: false
    t.boolean  "LocSearched",                limit: 1,                             default: false,  null: false
    t.string   "Transaction",                limit: 4,                             default: "sale", null: false
    t.text     "params",                     limit: 65535
    t.string   "primaryPhoto",               limit: 255
    t.text     "DeletedYN",                  limit: 65535
    t.text     "AssessmentsYN",              limit: 65535
    t.text     "AssociationName1",           limit: 65535
    t.text     "ContactOrder3",              limit: 65535
    t.text     "ContactOrder4",              limit: 65535
    t.text     "ContactOrder5",              limit: 65535
    t.text     "CoolingYN",                  limit: 65535
    t.text     "DateCmaStatus",              limit: 65535
    t.text     "Disclosures",                limit: 65535
    t.text     "FenceYN",                    limit: 65535
    t.text     "FireplaceYN",                limit: 65535
    t.text     "HeatingYN",                  limit: 65535
    t.text     "LastChangeType",             limit: 65535
    t.text     "PreviousPrice",              limit: 65535
    t.text     "LaundryYN",                  limit: 65535
    t.text     "PreviousStatus",             limit: 65535
    t.text     "ListPriceLow",               limit: 65535
    t.text     "PoolYN",                     limit: 65535
    t.text     "PatioYN",                    limit: 65535
    t.text     "CDOMResetYN",                limit: 65535
    t.text     "ContactOrder1",              limit: 65535
    t.text     "ContactOrder2",              limit: 65535
    t.text     "ContactOrder6",              limit: 65535
    t.text     "ParkingYN",                  limit: 65535
    t.text     "PricePerSqft",               limit: 65535
    t.text     "ShowingContactName",         limit: 65535
    t.text     "ShowingContactPhone",        limit: 65535
    t.text     "ShowingContactPhoneExt",     limit: 65535
    t.text     "ShowingContactType",         limit: 65535
    t.text     "SourceKey",                  limit: 65535
    t.text     "SourceTimestampModified",    limit: 65535
    t.text     "SpaYN",                      limit: 65535
    t.text     "SprinklersYN",               limit: 65535
    t.text     "TimestampOffMarket",         limit: 65535
    t.text     "TimestampStatusChange",      limit: 65535
    t.text     "TractName",                  limit: 65535
    t.text     "TractSubAreaCode",           limit: 65535
    t.text     "ViewYN",                     limit: 65535
  end

  add_index "carets_properties", ["BathsTotal"], name: "BathsTotal", using: :btree
  add_index "carets_properties", ["Bedrooms"], name: "Bedrooms", using: :btree
  add_index "carets_properties", ["City"], name: "City", using: :btree
  add_index "carets_properties", ["Latitude"], name: "Latitude", using: :btree
  add_index "carets_properties", ["ListPrice"], name: "ListPrice", using: :btree
  add_index "carets_properties", ["Longitude"], name: "Longitude", using: :btree
  add_index "carets_properties", ["MLnumber"], name: "MLnumber", using: :btree
  add_index "carets_properties", ["Matrix_Unique_ID"], name: "Matrix_Unique_ID", unique: true, using: :btree
  add_index "carets_properties", ["ZipCode", "Status"], name: "ZipCode", using: :btree

  create_table "carets_rentals", primary_key: "Propertyid", force: :cascade do |t|
    t.text     "AccessibilityFeatures",      limit: 65535
    t.decimal  "Acres",                                    precision: 9, scale: 3
    t.string   "AdNumber",                   limit: 15
    t.string   "APN",                        limit: 19
    t.text     "Appliances",                 limit: 65535
    t.string   "AppliancesYN",               limit: 1
    t.string   "Area",                       limit: 50
    t.text     "Association",                limit: 65535
    t.integer  "AssociationDues1",           limit: 4
    t.string   "AssociationDues1Frequency",  limit: 50
    t.integer  "AssociationDues2",           limit: 4
    t.string   "AssociationDues2Frequency",  limit: 50
    t.string   "AssociationYN",              limit: 1
    t.string   "AttachedStructure",          limit: 50
    t.integer  "BasementSqft",               limit: 4
    t.integer  "BathsFull",                  limit: 4
    t.integer  "BathsHalf",                  limit: 4
    t.integer  "BathsOqtr",                  limit: 4
    t.decimal  "BathsTotal",                               precision: 5, scale: 2
    t.integer  "BathsTqtr",                  limit: 4
    t.integer  "Bedrooms",                   limit: 4
    t.string   "BuildersName",               limit: 50
    t.string   "BuildersTractCode",          limit: 50
    t.string   "BuildersTractName",          limit: 40
    t.text     "CashiersCheck",              limit: 65535
    t.integer  "CDOM",                       limit: 4
    t.string   "City",                       limit: 50
    t.string   "CoLA_Board",                 limit: 50
    t.string   "CoLA_DreLicenseNumber",      limit: 20
    t.string   "CoLA_FirstName",             limit: 20
    t.string   "CoLA_LastName",              limit: 20
    t.string   "CoLA_PublicID",              limit: 30
    t.string   "CoLo_Code",                  limit: 30
    t.string   "CoLO_DreLicenseNumber",      limit: 20
    t.string   "CoLo_Name",                  limit: 30
    t.text     "CommonWalls",                limit: 65535
    t.text     "CommunityFeatures",          limit: 65535
    t.text     "ConstructionMaterials",      limit: 65535
    t.text     "Cooling",                    limit: 65535
    t.string   "CoSA_Board",                 limit: 50
    t.string   "CoSA_DreLicenseNumber",      limit: 20
    t.string   "CoSA_FirstName",             limit: 20
    t.string   "CoSA_LastName",              limit: 20
    t.string   "CoSA_PublicID",              limit: 30
    t.string   "CoSO_Code",                  limit: 30
    t.string   "CoSO_DreLicenseNumber",      limit: 20
    t.string   "CoSO_Name",                  limit: 30
    t.string   "Country",                    limit: 50
    t.string   "County",                     limit: 50
    t.string   "CrossStreets",               limit: 30
    t.datetime "DateLeased"
    t.datetime "DateListingContract"
    t.string   "DirectionFaces",             limit: 50
    t.string   "DocumentNumber",             limit: 50
    t.string   "DOH1",                       limit: 9
    t.string   "DOH2",                       limit: 9
    t.string   "DOH3",                       limit: 9
    t.integer  "DOM",                        limit: 4
    t.text     "DoorFeatures",               limit: 65535
    t.string   "DrivingDirections",          limit: 250
    t.text     "EatingArea",                 limit: 65535
    t.string   "Elevation",                  limit: 9
    t.integer  "EntryLevel",                 limit: 4
    t.text     "EntryLocation",              limit: 65535
    t.text     "ExteriorFeatures",           limit: 65535
    t.text     "Fencing",                    limit: 65535
    t.text     "Fireplace",                  limit: 65535
    t.text     "Floor",                      limit: 65535
    t.text     "Foundation",                 limit: 65535
    t.string   "Furnished",                  limit: 50
    t.string   "GarageAttached",             limit: 50
    t.string   "GreenBuildingCertification", limit: 50
    t.decimal  "GreenCertificationRating",                 precision: 6, scale: 2
    t.string   "GreenCertifyingBody",        limit: 50
    t.text     "GreenEnergyEfficient",       limit: 65535
    t.text     "GreenEnergyGeneration",      limit: 65535
    t.text     "GreenIndoorAirQuality",      limit: 65535
    t.text     "GreenLocation",              limit: 65535
    t.text     "GreenSustainability",        limit: 65535
    t.integer  "GreenWalkScore",             limit: 4
    t.text     "GreenWaterConservation",     limit: 65535
    t.integer  "GreenYearCertified",         limit: 4
    t.text     "Heating",                    limit: 65535
    t.string   "InsuranceWaterFurnitureYN",  limit: 1
    t.text     "InteriorFeatures",           limit: 65535
    t.string   "InternetSendAddressYN",      limit: 1
    t.string   "InternetSendListingYN",      limit: 1
    t.string   "LA_Board",                   limit: 50
    t.string   "LA_DreLicenseNumber",        limit: 20
    t.string   "LA_FirstName",               limit: 20
    t.string   "LA_LastName",                limit: 20
    t.string   "LA_PublicID",                limit: 30
    t.float    "Latitude",                   limit: 53
    t.text     "Laundry",                    limit: 65535
    t.string   "License1",                   limit: 9
    t.string   "License2",                   limit: 9
    t.string   "License3",                   limit: 9
    t.integer  "ListPrice",                  limit: 4
    t.string   "ListPriceExcludes",          limit: 250
    t.string   "ListPriceIncludes",          limit: 250
    t.string   "LO_Code",                    limit: 30
    t.string   "LO_Name",                    limit: 30
    t.float    "Longitude",                  limit: 53
    t.string   "LotDimensions",              limit: 40
    t.text     "LotFeatures",                limit: 65535
    t.string   "LotNumber",                  limit: 4
    t.integer  "LotSquareFootage",           limit: 4
    t.string   "Make",                       limit: 40
    t.integer  "Matrix_Unique_ID",           limit: 8,                             default: 0, null: false
    t.string   "MLnumber",                   limit: 12
    t.string   "MLS_ID",                     limit: 50
    t.string   "ModelCode",                  limit: 1
    t.string   "ModelName",                  limit: 14
    t.integer  "NumberCarportSpaces",        limit: 4
    t.integer  "NumberGarageSpaces",         limit: 4
    t.integer  "NumberParkingSpaces",        limit: 4
    t.integer  "NumberRemotes",              limit: 4
    t.integer  "NumberUncoveredSpaces",      limit: 4
    t.integer  "NumberUnits",                limit: 4
    t.text     "OtherStructures",            limit: 65535
    t.text     "Parking",                    limit: 65535
    t.text     "Patio",                      limit: 65535
    t.string   "PetsAllowed",                limit: 50
    t.integer  "PicCount",                   limit: 4
    t.text     "Pool",                       limit: 65535
    t.text     "PropertyDescription",        limit: 65535
    t.string   "PropertySubType",            limit: 50
    t.text     "Roofing",                    limit: 65535
    t.text     "Rooms",                      limit: 65535
    t.string   "RVAccessDimensions",         limit: 7
    t.string   "SA_Board",                   limit: 50
    t.string   "SA_DreLicenseNumber",        limit: 20
    t.string   "SA_FirstName",               limit: 20
    t.string   "SA_LastName",                limit: 20
    t.string   "SA_PublicID",                limit: 30
    t.text     "SaleType",                   limit: 65535
    t.string   "SaleYN",                     limit: 1
    t.string   "SchoolDistrict",             limit: 50
    t.string   "SchoolElementary",           limit: 20
    t.string   "SchoolHigh",                 limit: 20
    t.string   "SchoolJuniorHigh",           limit: 20
    t.text     "SecurityFeatures",           limit: 65535
    t.integer  "SellingPrice",               limit: 4
    t.string   "SeniorYN",                   limit: 1
    t.string   "SerialU",                    limit: 25
    t.string   "SerialX",                    limit: 25
    t.string   "SerialXX",                   limit: 25
    t.text     "Sewer",                      limit: 65535
    t.string   "SO_Code",                    limit: 30
    t.string   "SO_DreLicenseNumber",        limit: 20
    t.string   "SO_Name",                    limit: 30
    t.text     "Spa",                        limit: 65535
    t.string   "SqFtSourceLot",              limit: 50
    t.string   "SqFtSourceStructure",        limit: 50
    t.integer  "SquareFootageStructure",     limit: 4
    t.string   "State",                      limit: 50
    t.string   "Status",                     limit: 50
    t.string   "Stories",                    limit: 50
    t.integer  "StoriesTotal",               limit: 4
    t.string   "StreetDirection",            limit: 50
    t.string   "StreetDirectionSuffix",      limit: 50
    t.string   "StreetName",                 limit: 30
    t.integer  "StreetNumber",               limit: 4
    t.string   "StreetNumberModifier",       limit: 8
    t.string   "StreetSuffix",               limit: 50
    t.string   "StreetSuffixModifier",       limit: 15
    t.text     "StructuralCondition",        limit: 65535
    t.text     "Style",                      limit: 65535
    t.string   "ThomasGuide",                limit: 7
    t.datetime "TimestampModified"
    t.datetime "TimestampPhotoModified"
    t.string   "TractNumber",                limit: 6
    t.string   "UnitNumber",                 limit: 6
    t.text     "Utilities",                  limit: 65535
    t.text     "View",                       limit: 65535
    t.string   "VirtualTour",                limit: 255
    t.text     "WaterSource",                limit: 65535
    t.integer  "WellDepth",                  limit: 4
    t.decimal  "WellGallonsPerMinute",                     precision: 6, scale: 2
    t.decimal  "WellPumpHorsepower",                       precision: 6, scale: 2
    t.string   "WellReportYN",               limit: 1
    t.text     "WindowFeatures",             limit: 65535
    t.integer  "YearBuilt",                  limit: 4
    t.string   "YearBuiltSource",            limit: 50
    t.string   "ZipCode",                    limit: 10
    t.string   "ZipCodePlus4",               limit: 4
    t.string   "Zone",                       limit: 40
    t.integer  "PhotoImported",              limit: 1
    t.integer  "LocSearched",                limit: 1
  end

  add_index "carets_rentals", ["City"], name: "City", using: :btree
  add_index "carets_rentals", ["Matrix_Unique_ID"], name: "Matrix", using: :btree
  add_index "carets_rentals", ["ZipCode"], name: "ZipCode", using: :btree

  create_table "categories", primary_key: "category_id", force: :cascade do |t|
    t.string  "category",  limit: 150,                     null: false
    t.string  "section",   limit: 7,   default: "content", null: false
    t.integer "parent_id", limit: 4,   default: 0,         null: false
  end

  add_index "categories", ["category"], name: "category", using: :btree

  create_table "cities", force: :cascade do |t|
    t.string  "city",              limit: 30, default: "", null: false
    t.integer "countyid",          limit: 3,               null: false
    t.integer "stateid",           limit: 4,  default: 0,  null: false
    t.float   "latitude",          limit: 53
    t.float   "longitude",         limit: 53
    t.integer "active_properties", limit: 4
  end

  add_index "cities", ["countyid"], name: "COUNTYID", using: :btree
  add_index "cities", ["stateid"], name: "state", using: :btree

  create_table "communities", primary_key: "community_id", force: :cascade do |t|
    t.string  "community", limit: 255
    t.string  "city",      limit: 150,                 null: false
    t.string  "state",     limit: 6
    t.integer "zip",       limit: 4,                   null: false
    t.float   "latitude",  limit: 53
    t.float   "longitude", limit: 53
    t.integer "cnt",       limit: 2,                   null: false
    t.boolean "published", limit: 1,   default: false, null: false
  end

  add_index "communities", ["zip"], name: "zip", using: :btree

  create_table "content", primary_key: "content_id", force: :cascade do |t|
    t.text     "title",            limit: 65535, null: false
    t.text     "content",          limit: 65535, null: false
    t.integer  "category_id",      limit: 4,     null: false
    t.datetime "added_at",                       null: false
    t.integer  "added_by",         limit: 4,     null: false
    t.integer  "is_published",     limit: 4,     null: false
    t.boolean  "is_featured",      limit: 1,     null: false
    t.integer  "views",            limit: 4
    t.text     "meta_tags",        limit: 65535
    t.text     "meta_description", limit: 65535
    t.text     "slug",             limit: 65535, null: false
  end

  add_index "content", ["category_id"], name: "category_id", using: :btree

  create_table "counties", force: :cascade do |t|
    t.string  "countyid", limit: 5,     default: "",  null: false
    t.string  "county",   limit: 120,   default: "",  null: false
    t.integer "stateid",  limit: 4,     default: 0,   null: false
    t.text    "params",   limit: 65535,               null: false
    t.string  "priority", limit: 1,     default: "3", null: false
    t.string  "slug",     limit: 255,   default: "",  null: false
  end

  add_index "counties", ["countyid"], name: "countyid", using: :btree

  create_table "daily_rates", primary_key: "ID", force: :cascade do |t|
    t.string "pgrm_1",      limit: 30
    t.string "pgrm_2",      limit: 30
    t.string "pgrm_3",      limit: 30
    t.string "pgrm_4",      limit: 30
    t.string "pgrm_5",      limit: 30
    t.string "rate_1",      limit: 10,  null: false
    t.string "rate_2",      limit: 10,  null: false
    t.string "rate_3",      limit: 10,  null: false
    t.string "rate_4",      limit: 10,  null: false
    t.string "rate_5",      limit: 10,  null: false
    t.string "rate_6",      limit: 10,  null: false
    t.string "rate_7",      limit: 10,  null: false
    t.string "rate_8",      limit: 10,  null: false
    t.string "rate_9",      limit: 10,  null: false
    t.string "rate_10",     limit: 10,  null: false
    t.string "rate_11",     limit: 10,  null: false
    t.string "rate_12",     limit: 10,  null: false
    t.string "rate_13",     limit: 10,  null: false
    t.string "rate_14",     limit: 10,  null: false
    t.string "rate_15",     limit: 10,  null: false
    t.string "apr_1",       limit: 10,  null: false
    t.string "apr_2",       limit: 10,  null: false
    t.string "apr_3",       limit: 10,  null: false
    t.string "apr_4",       limit: 10,  null: false
    t.string "apr_5",       limit: 10,  null: false
    t.string "apr_6",       limit: 10,  null: false
    t.string "apr_7",       limit: 10,  null: false
    t.string "apr_8",       limit: 10,  null: false
    t.string "apr_9",       limit: 10,  null: false
    t.string "apr_10",      limit: 10,  null: false
    t.string "apr_11",      limit: 10,  null: false
    t.string "apr_12",      limit: 10,  null: false
    t.string "apr_13",      limit: 10,  null: false
    t.string "apr_14",      limit: 10,  null: false
    t.string "apr_15",      limit: 10,  null: false
    t.string "pts_1",       limit: 10,  null: false
    t.string "pts_2",       limit: 10,  null: false
    t.string "pts_3",       limit: 10,  null: false
    t.string "pts_4",       limit: 10,  null: false
    t.string "pts_5",       limit: 10,  null: false
    t.string "pts_6",       limit: 10,  null: false
    t.string "pts_7",       limit: 10,  null: false
    t.string "pts_8",       limit: 10,  null: false
    t.string "pts_9",       limit: 10,  null: false
    t.string "pts_10",      limit: 10,  null: false
    t.string "pts_11",      limit: 10,  null: false
    t.string "pts_12",      limit: 10,  null: false
    t.string "pts_13",      limit: 10,  null: false
    t.string "pts_14",      limit: 10,  null: false
    t.string "pts_15",      limit: 10,  null: false
    t.string "assumptions", limit: 255, null: false
    t.string "rate_date",   limit: 25,  null: false
  end

  create_table "favorites", primary_key: "fav_id", force: :cascade do |t|
    t.integer  "user_id",          limit: 4, null: false
    t.integer  "property_id",      limit: 4, null: false
    t.integer  "matrix_id",        limit: 4, null: false
    t.string   "transaction_type", limit: 4, null: false
    t.datetime "added_at",                   null: false
    t.boolean  "email_alert",      limit: 1
  end

  create_table "inquiries", primary_key: "inquiry_id", force: :cascade do |t|
    t.text     "inquiry",      limit: 65535, null: false
    t.string   "first_name",   limit: 60,    null: false
    t.string   "last_name",    limit: 60,    null: false
    t.string   "email",        limit: 60,    null: false
    t.string   "phone_number", limit: 60
    t.datetime "added_at",                   null: false
    t.integer  "ip",           limit: 4,     null: false
    t.integer  "propertyid",   limit: 4,     null: false
    t.text     "request_uri",  limit: 65535, null: false
  end

  create_table "menus", primary_key: "menu_id", force: :cascade do |t|
    t.string  "menu_component",  limit: 255
    t.string  "menu_url",        limit: 255
    t.string  "menu",            limit: 120,               null: false
    t.string  "menu_type",       limit: 9,                 null: false
    t.integer "menu_content_id", limit: 4
    t.text    "menu_params",     limit: 65535
    t.integer "menu_group_id",   limit: 4,                 null: false
    t.integer "menu_order",      limit: 2,                 null: false
    t.boolean "menu_published",  limit: 1,                 null: false
    t.integer "parent_id",       limit: 4,     default: 0, null: false
  end

  create_table "notes", primary_key: "note_id", force: :cascade do |t|
    t.text     "note",      limit: 65535, null: false
    t.integer  "entity_id", limit: 4,     null: false
    t.string   "entity",    limit: 16,    null: false
    t.datetime "added_at",                null: false
  end

  create_table "oauth_access_grants", force: :cascade do |t|
    t.integer  "resource_owner_id", limit: 4,     null: false
    t.integer  "application_id",    limit: 4,     null: false
    t.string   "token",             limit: 255,   null: false
    t.integer  "expires_in",        limit: 4,     null: false
    t.text     "redirect_uri",      limit: 65535, null: false
    t.datetime "created_at",                      null: false
    t.datetime "revoked_at"
    t.string   "scopes",            limit: 255
  end

  add_index "oauth_access_grants", ["token"], name: "index_oauth_access_grants_on_token", unique: true, using: :btree

  create_table "oauth_access_tokens", force: :cascade do |t|
    t.integer  "resource_owner_id", limit: 4
    t.integer  "application_id",    limit: 4
    t.string   "token",             limit: 255, null: false
    t.string   "refresh_token",     limit: 255
    t.integer  "expires_in",        limit: 4
    t.datetime "revoked_at"
    t.datetime "created_at",                    null: false
    t.string   "scopes",            limit: 255
  end

  add_index "oauth_access_tokens", ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true, using: :btree
  add_index "oauth_access_tokens", ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id", using: :btree
  add_index "oauth_access_tokens", ["token"], name: "index_oauth_access_tokens_on_token", unique: true, using: :btree

  create_table "oauth_applications", force: :cascade do |t|
    t.string   "name",         limit: 255,                null: false
    t.string   "uid",          limit: 255,                null: false
    t.string   "secret",       limit: 255,                null: false
    t.text     "redirect_uri", limit: 65535,              null: false
    t.string   "scopes",       limit: 255,   default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "oauth_applications", ["uid"], name: "index_oauth_applications_on_uid", unique: true, using: :btree

  create_table "photos_highres", primary_key: "photo_id", force: :cascade do |t|
    t.string  "url",         limit: 255,   null: false
    t.integer "matrix_id",   limit: 4
    t.integer "property_id", limit: 4,     null: false
    t.integer "photo_order", limit: 2
    t.string  "server",      limit: 120
    t.text    "params",      limit: 65535
  end

  add_index "photos_highres", ["matrix_id"], name: "matrix_id", using: :btree
  add_index "photos_highres", ["property_id"], name: "property_id", using: :btree

  create_table "process_reports", primary_key: "process_id", force: :cascade do |t|
    t.string   "process",      limit: 120,   null: false
    t.datetime "processed_at",               null: false
    t.text     "start_result", limit: 65535, null: false
    t.text     "end_result",   limit: 65535, null: false
    t.text     "params",       limit: 65535
  end

  create_table "relationships", primary_key: "rel_id", force: :cascade do |t|
    t.string  "relationship", limit: 16,    null: false
    t.integer "group_id",     limit: 4,     null: false
    t.integer "member_id",    limit: 4,     null: false
    t.text    "params",       limit: 65535
  end

  add_index "relationships", ["group_id"], name: "group_id", using: :btree

  create_table "search_history", primary_key: "search_id", force: :cascade do |t|
    t.integer "ip",             limit: 4
    t.integer "current_offset", limit: 3
    t.string  "session_id",     limit: 64,    null: false
    t.integer "user_id",        limit: 4
    t.text    "search_keyword", limit: 65535
    t.integer "searched_at",    limit: 4,     null: false
    t.integer "search_count",   limit: 2,     null: false
    t.text    "query",          limit: 65535, null: false
    t.text    "to_string",      limit: 65535
    t.integer "offset",         limit: 2
    t.integer "total",          limit: 2
    t.string  "search_table",   limit: 17
    t.text    "params",         limit: 65535
  end

  add_index "search_history", ["session_id"], name: "session_id", using: :btree
  add_index "search_history", ["user_id"], name: "user_id", using: :btree

  create_table "settings", primary_key: "settings_id", force: :cascade do |t|
    t.string "key",    limit: 160,                            null: false
    t.text   "value",  limit: 65535,                          null: false
    t.text   "params", limit: 65535
    t.string "type",   limit: 12,    default: "user defined"
  end

  add_index "settings", ["key"], name: "key", using: :btree

  create_table "states", force: :cascade do |t|
    t.string  "stateid",   limit: 2
    t.string  "state",     limit: 60
    t.integer "countryid", limit: 1,  default: 1, null: false
    t.float   "latitude",  limit: 53
    t.float   "longitude", limit: 53
  end

  add_index "states", ["countryid"], name: "countryid", using: :btree
  add_index "states", ["stateid"], name: "STATEID", using: :btree

  create_table "stats", primary_key: "stat_id", force: :cascade do |t|
    t.string  "stat",       limit: 120,   null: false
    t.date    "stat_date",                null: false
    t.integer "stat_count", limit: 4,     null: false
    t.text    "params",     limit: 65535
  end

  add_index "stats", ["stat"], name: "stat", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "user_key",      limit: 16,                           null: false
    t.string   "usertype",      limit: 10,    default: "registered", null: false
    t.string   "first_name",    limit: 40,                           null: false
    t.string   "last_name",     limit: 40,                           null: false
    t.string   "email",         limit: 80,                           null: false
    t.string   "phone",         limit: 32
    t.string   "username",      limit: 60,                           null: false
    t.string   "password",      limit: 48,                           null: false
    t.datetime "registered_at",                                      null: false
    t.datetime "last_login"
    t.integer  "login_count",   limit: 4
    t.text     "params",        limit: 65535
  end

  add_index "users", ["user_key"], name: "user_key", unique: true, using: :btree
  add_index "users", ["username"], name: "username", unique: true, using: :btree

  create_table "zips", primary_key: "zipId", force: :cascade do |t|
    t.string   "ZipCode",                 limit: 12, default: "",    null: false
    t.float    "Latitude",                limit: 53,                 null: false
    t.float    "Longitude",               limit: 53,                 null: false
    t.string   "State",                   limit: 12, default: "",    null: false
    t.string   "StateFullName",           limit: 24, default: "",    null: false
    t.string   "CityType",                limit: 12, default: "",    null: false
    t.string   "CityAliasAbbreviation",   limit: 50, default: "",    null: false
    t.string   "AreaCode",                limit: 12, default: "",    null: false
    t.string   "City",                    limit: 50, default: "",    null: false
    t.string   "CityAliasName",           limit: 50, default: "",    null: false
    t.string   "CountyName",              limit: 50, default: "",    null: false
    t.string   "CountyFIPS",              limit: 12, default: "",    null: false
    t.string   "StateFIPS",               limit: 12, default: "",    null: false
    t.string   "TimeZone",                limit: 12, default: "",    null: false
    t.string   "DayLightSaving",          limit: 12, default: "",    null: false
    t.boolean  "IsImported",              limit: 1,  default: false, null: false
    t.boolean  "IsCurrentImported",       limit: 1,  default: false, null: false
    t.integer  "TotalProperties",         limit: 3
    t.integer  "CurrentOffset",           limit: 3
    t.datetime "ImportStartAt"
    t.datetime "ImportEndAt"
    t.boolean  "IsRentalImported",        limit: 1
    t.boolean  "IsRentalCurrentImported", limit: 1
    t.integer  "TotalRentals",            limit: 3
    t.integer  "CurrentRentalOffset",     limit: 3
  end

  add_index "zips", ["Latitude"], name: "Latitude", using: :btree
  add_index "zips", ["Longitude"], name: "Longitude", using: :btree
  add_index "zips", ["State"], name: "State", using: :btree
  add_index "zips", ["ZipCode"], name: "ZipCode", unique: true, using: :btree

  create_table "zips_cities", force: :cascade do |t|
    t.integer "zip",    limit: 3,   null: false
    t.string  "city",   limit: 120, null: false
    t.string  "county", limit: 60,  null: false
  end

  add_index "zips_cities", ["zip"], name: "zip", using: :btree

  create_table "zips_nearby", force: :cascade do |t|
    t.integer "zip",        limit: 3,  null: false
    t.integer "nearby_zip", limit: 3,  null: false
    t.float   "distance",   limit: 53, null: false
  end

  add_index "zips_nearby", ["zip"], name: "zip", using: :btree

end
