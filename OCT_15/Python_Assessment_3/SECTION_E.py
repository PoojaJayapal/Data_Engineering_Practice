# Q47: write 3 messages
with open("event_log.txt", "w") as f:
    f.write("Event E101 registration processing started\n")
    f.write("Event E102 payment verified\n")
    f.write("Event E103 attendee list generated\n")

# Q48: append 2 more
with open("event_log.txt", "a") as f:
    f.write("Event E104 cancellation processed\n")
    f.write("Event E105 venue confirmed\n")

# Q49: read the complete file
with open("event_log.txt", "r") as f:
    print(f.read())

# Q50-51: line by line, no extra blank lines
with open("event_log.txt", "r") as f:
    for line in f:
        print(line.strip())      # or print(line, end="")
