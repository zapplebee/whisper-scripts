docker run -v ${PWD}/${FILE}:/app/output/foo -v ${PWD}/output.txt:/app/output.txt aaudio whisper foo --output_format txt