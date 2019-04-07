import groovy.json.JsonSlurper

class GenerateKeymap {
    static String INDENT = "    "
    static String BACKSLASH = "\\"
    // https://docs.qmk.fm/#/keycodes

    static void main(String[] args) {
        String filePath = args[0]

        String downloadedKeymapFile = new File(filePath).text

        List<List<String>> layers = (new JsonSlurper().parseText(downloadedKeymapFile) as Map).layers

        List<String> layout = (0..(layers.size() - 1)).collect { generateLayer(it, layers[it]) }

        print(layout.join("\n"))
        print("\n")
    }

    private static String generateLayer(Integer layerIndex, List<String> keys) {

        StringBuilder sb = new StringBuilder()

        sb.append("${INDENT}[${layerIndex}] = LAYOUT_truefox( ${BACKSLASH}\n")

        // indicate the number of keys for each line
        List<Integer> numberOfKeys = [
            16,
            15,
            14,
            14,
            9
        ]

        int start = 1
        numberOfKeys.eachWithIndex { int keysNumber, int i ->
            List<String> lineKeys = (start..(start + keysNumber - 1)).collect { keys[it - 1] }

            sb.append("${INDENT}${INDENT}${lineKeys.join(', ')}")

            if (i != numberOfKeys.size() - 1) {
                sb.append(', ')
            }
            else {
                sb.append(' ')
            }

            sb.append("${BACKSLASH}\n")

            start = start + keysNumber
        }

        sb.append("${INDENT}),")

        return sb.toString()
    }
}
