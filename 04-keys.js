import { call, getSql, saveJson } from "./shared.js"

const systemPrompt = `
You are a senior database expert. 

Review the following MySQL schema. Check only for constraints and keys issues (e.g., missing primary keys, foreign key issues, incorrect uniqueness, missing/not null constraints, defaults).
Suggest efficient alternatives and fixes.

Output format should be a JSON object:
{
    "notes": [
        { 
            "content": "string", 
            "priority": 1 | 2 | 3 | 4 | 5 
        }
    ],
    "constraints": [
        {
          "table": "string",
          "column": "string | null",
          "issue": "missing_pk | missing_fk | missing_unique | missing_not_null | unnecessary_fk | suboptimal_default",
          "priority": 1 | 2 | 3 | 4 | 5,
          "suggestedConstraint": "string",
          "reason": "string"
        }
    ]
}

Don't include texts before and after json object. also avoid using \`\`\`json...
`

const result = await call({systemPrompt, userMessage: `Here is the sql file: ` + getSql()})


const json = JSON.parse(result.content)
saveJson('./keys-result.json', json)