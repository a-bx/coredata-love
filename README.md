coredata-love
=============

###Core Data Love Talk sources

    $ bundle install
    $ pod install
    $ open CoreDataInLove.xcworkspace

    Run test: CTRL+U

###Install MoGenerator

    $ brew install mogenerator

###Generate Managed Objects

    mogenerator
       --model CoreDataInLove/Model/CoreDataInLove.xcdatamodeld/CoreDataInLove.xcdatamodel
       -O CoreDataInLove/NewModel
       -M CoreDataInLove/NewModel/Machine
       --template-var arc=true