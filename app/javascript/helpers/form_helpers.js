import { FetchRequest } from "@rails/request.js"

export async function submitForm(form) {
  const request = new FetchRequest(form.method, form.action, {
    body: new FormData(form)
  })

  return await request.perform()
}
