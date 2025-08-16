import { readFileSync, writeFileSync } from 'fs'
import { call, getSql, saveJson } from './shared.js';

const sql = getSql()

const result = await call({
    systemPrompt: `
You are a senior database expert. 

Your task is to analyze the provided SQL script and generate comprehensive documentation. 

Follow this JSON structure exactly:
{
  "tables": [
    {
      "name": "string",
      "description": "string",
      "fields": [
        {
          "name": "string",
          "description": "string",
          "dataType": "string",
          "constraints": ["string"]
        }
      ]
    }
  ],
  "notes": "string"
}

Instructions:

Extract all tables, columns, data types, and constraints from the SQL script.

Provide meaningful descriptions for tables and columns based on names and context.

Include primary keys, foreign keys, unique, not null, default values, and any other constraints in the constraints array.

Add general observations about the database in the notes field (e.g., normalization issues, relationships, indexing hints).

Return JSON only. Do not include any extra text, explanations, or code blocks.

Ensure the JSON is valid and properly nested.
    `,
    userMessage: `Here is the sql script: ${sql}` 
})

const docs = JSON.parse(result.content);
saveJson('./result.json', docs)

function convertDocToMarkdown(docs) {
    let result = ''


    for(let table of docs.tables) {
        result += '## ' + table.name + '\n'
        result += '' + table.description + '\n'

        result += '### Fields\n'

        for(let field of table.fields) {
            result += '* **' + field.name + `** (${field.dataType} - ${(field.constraints ?? []).join(', ')}):` + field.description + '\n'

        }
        result += '\n'
    }


    result += '\n'
    result += '## Notes\n'
    result += docs.notes

    return result
}

writeFileSync('./result.md', convertDocToMarkdown(docs))