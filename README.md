# README for the robot

Installation
------------

Simply run the following commands to install the robot framework
and the required Seleniumlibrary

    pip install robotframework
    pip install robotframework-seleniumlibrary

## User story

As a traveller, I want to calculate the various purchase/tax amounts to verify that my shop
receipt is correct, and the merchant correctly charged the VAT for my recently bought items.

## Run scripts

    robot -d.\tests\Reports .\tests\Vat-calculator.robot
